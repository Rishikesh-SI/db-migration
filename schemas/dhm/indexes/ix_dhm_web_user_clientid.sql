-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dhm
-- Object: ix_dhm_web_user_clientid
-- Type: INDEX

-- Name: ix_dhm_web_user_clientid; Type: INDEX; Schema: dhm; Owner: -
--

CREATE INDEX ix_dhm_web_user_clientid ON dhm.dhm_web_user USING btree (upper_email_id, client_id);


--
