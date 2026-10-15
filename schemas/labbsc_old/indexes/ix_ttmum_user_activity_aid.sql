-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc_old
-- Object: ix_ttmum_user_activity_aid
-- Type: INDEX

-- Name: ix_ttmum_user_activity_aid; Type: INDEX; Schema: labbsc_old; Owner: -
--

CREATE INDEX ix_ttmum_user_activity_aid ON labbsc_old.labbsc_user_activity USING btree (user_id);


--
