-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: eks
-- Object: ss_user_upper_email_id_ix
-- Type: INDEX

-- Name: ss_user_upper_email_id_ix; Type: INDEX; Schema: eks; Owner: -
--

CREATE UNIQUE INDEX ss_user_upper_email_id_ix ON eks.ss_user USING btree (upper_email_id, cf_clientid);


--
