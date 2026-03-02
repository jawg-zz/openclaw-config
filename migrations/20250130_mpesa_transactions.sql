-- Create table for M-Pesa transactions
CREATE TABLE IF NOT EXISTS mpesa_transactions (
    id BIGSERIAL PRIMARY KEY,
    transaction_id VARCHAR(50) NOT NULL UNIQUE,
    transaction_type VARCHAR(50) NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    phone_number VARCHAR(20) NOT NULL,
    first_name VARCHAR(100),
    middle_name VARCHAR(100),
    last_name VARCHAR(100),
    transaction_timestamp TIMESTAMP WITH TIME ZONE NOT NULL,
    raw_data JSONB NOT NULL DEFAULT '{}',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_mpesa_transactions_transaction_id ON mpesa_transactions(transaction_id);
CREATE INDEX IF NOT EXISTS idx_mpesa_transactions_phone_number ON mpesa_transactions(phone_number);
CREATE INDEX IF NOT EXISTS idx_mpesa_transactions_transaction_timestamp ON mpesa_transactions(transaction_timestamp DESC);
CREATE INDEX IF NOT EXISTS idx_mpesa_transactions_transaction_type ON mpesa_transactions(transaction_type);
CREATE INDEX IF NOT EXISTS idx_mpesa_transactions_created_at ON mpesa_transactions(created_at DESC);

ALTER TABLE mpesa_transactions ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "Users can view their transactions" ON mpesa_transactions;
CREATE POLICY "Users can view their transactions" ON mpesa_transactions FOR SELECT USING (auth.uid() IS NOT NULL);
