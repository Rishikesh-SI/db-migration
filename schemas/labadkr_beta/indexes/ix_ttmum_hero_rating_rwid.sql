-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labadkr_beta
-- Object: ix_ttmum_hero_rating_rwid
-- Type: INDEX

-- Name: ix_ttmum_hero_rating_rwid; Type: INDEX; Schema: labadkr_beta; Owner: -
--

CREATE INDEX ix_ttmum_hero_rating_rwid ON labadkr_beta.labadkr_hero_rating USING btree (rating_week_id);


--
