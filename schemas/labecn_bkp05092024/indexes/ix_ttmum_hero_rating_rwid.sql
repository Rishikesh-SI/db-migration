-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labecn_bkp05092024
-- Object: ix_ttmum_hero_rating_rwid
-- Type: INDEX

-- Name: ix_ttmum_hero_rating_rwid; Type: INDEX; Schema: labecn_bkp05092024; Owner: -
--

CREATE INDEX ix_ttmum_hero_rating_rwid ON labecn_bkp05092024.labecn_hero_rating USING btree (rating_week_id);


--
