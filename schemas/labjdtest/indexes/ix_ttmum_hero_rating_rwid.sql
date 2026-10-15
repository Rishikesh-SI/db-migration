-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labjdtest
-- Object: ix_ttmum_hero_rating_rwid
-- Type: INDEX

-- Name: ix_ttmum_hero_rating_rwid; Type: INDEX; Schema: labjdtest; Owner: -
--

CREATE INDEX ix_ttmum_hero_rating_rwid ON labjdtest.labjdtest_hero_rating USING btree (rating_week_id);


--
