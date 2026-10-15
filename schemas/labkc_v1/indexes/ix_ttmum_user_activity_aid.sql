-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkc_v1
-- Object: ix_ttmum_user_activity_aid
-- Type: INDEX

-- Name: ix_ttmum_user_activity_aid; Type: INDEX; Schema: labkc_v1; Owner: -
--

CREATE INDEX ix_ttmum_user_activity_aid ON labkc_v1.labkc_v1_user_activity USING btree (user_id);


--
