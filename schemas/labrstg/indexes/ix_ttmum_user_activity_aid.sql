-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrstg
-- Object: ix_ttmum_user_activity_aid
-- Type: INDEX

-- Name: ix_ttmum_user_activity_aid; Type: INDEX; Schema: labrstg; Owner: -
--

CREATE INDEX ix_ttmum_user_activity_aid ON labrstg.labrstg_user_activity USING btree (user_id);


--
