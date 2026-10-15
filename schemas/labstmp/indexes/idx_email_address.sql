-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labstmp
-- Object: idx_email_address
-- Type: INDEX

-- Name: idx_email_address; Type: INDEX; Schema: labstmp; Owner: -
--

CREATE INDEX idx_email_address ON labstmp.labstmp_emailer_emails USING btree (email_id);


--
