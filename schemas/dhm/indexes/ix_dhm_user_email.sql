-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dhm
-- Object: ix_dhm_user_email
-- Type: INDEX

-- Name: ix_dhm_user_email; Type: INDEX; Schema: dhm; Owner: -
--

CREATE INDEX ix_dhm_user_email ON dhm.dhm_user_master USING btree (upper(email_id));


--
