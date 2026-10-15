-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dhm
-- Object: ix_mum_user_emailid
-- Type: INDEX

-- Name: ix_mum_user_emailid; Type: INDEX; Schema: dhm; Owner: -
--

CREATE INDEX ix_mum_user_emailid ON dhm.dhm_user USING btree (email_id);


--
