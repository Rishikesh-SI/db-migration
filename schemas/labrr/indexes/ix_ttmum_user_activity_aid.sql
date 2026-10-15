-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrr
-- Object: ix_ttmum_user_activity_aid
-- Type: INDEX

-- Name: ix_ttmum_user_activity_aid; Type: INDEX; Schema: labrr; Owner: -
--

CREATE INDEX ix_ttmum_user_activity_aid ON labrr.labrr_user_activity USING btree (user_id);


--
