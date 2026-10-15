-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkiug
-- Object: ix_ttmum_user_activity_aid
-- Type: INDEX

-- Name: ix_ttmum_user_activity_aid; Type: INDEX; Schema: labkiug; Owner: -
--

CREATE INDEX ix_ttmum_user_activity_aid ON labkiug.labkiug_user_activity USING btree (user_id);


--
