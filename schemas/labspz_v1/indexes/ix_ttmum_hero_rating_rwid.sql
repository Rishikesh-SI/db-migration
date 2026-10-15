-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labspz_v1
-- Object: ix_ttmum_hero_rating_rwid
-- Type: INDEX

-- Name: ix_ttmum_hero_rating_rwid; Type: INDEX; Schema: labspz_v1; Owner: -
--

CREATE INDEX ix_ttmum_hero_rating_rwid ON labspz_v1.labspz_v1_hero_rating USING btree (rating_week_id);


--
