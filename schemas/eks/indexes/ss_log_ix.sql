-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: eks
-- Object: ss_log_ix
-- Type: INDEX

-- Name: ss_log_ix; Type: INDEX; Schema: eks; Owner: -
--

CREATE INDEX ss_log_ix ON eks.ss_log USING btree (updated_date);


--
