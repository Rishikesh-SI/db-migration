-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdv
-- Object: ix_ttmum_hero_rating_rwid
-- Type: INDEX

-- Name: ix_ttmum_hero_rating_rwid; Type: INDEX; Schema: labdv; Owner: -
--

CREATE INDEX ix_ttmum_hero_rating_rwid ON labdv.labdv_hero_rating USING btree (rating_week_id);


--
