-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labspz_v1
-- Object: ix_ttmum_user_activity_aid
-- Type: INDEX

-- Name: ix_ttmum_user_activity_aid; Type: INDEX; Schema: labspz_v1; Owner: -
--

CREATE INDEX ix_ttmum_user_activity_aid ON labspz_v1.labspz_v1_user_activity USING btree (user_id);


--
