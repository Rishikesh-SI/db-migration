-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labwis
-- Object: ix_ttmum_hero_rating_rwid
-- Type: INDEX

-- Name: ix_ttmum_hero_rating_rwid; Type: INDEX; Schema: labwis; Owner: -
--

CREATE INDEX ix_ttmum_hero_rating_rwid ON labwis.labwis_hero_rating USING btree (rating_week_id);


--
