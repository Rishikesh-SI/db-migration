-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dhm
-- Object: ix_mum_user_activity_aid
-- Type: INDEX

-- Name: ix_mum_user_activity_aid; Type: INDEX; Schema: dhm; Owner: -
--

CREATE INDEX ix_mum_user_activity_aid ON dhm.dhm_user_activity USING btree (user_id);


--
