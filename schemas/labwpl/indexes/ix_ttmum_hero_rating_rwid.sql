-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labwpl
-- Object: ix_ttmum_hero_rating_rwid
-- Type: INDEX

-- Name: ix_ttmum_hero_rating_rwid; Type: INDEX; Schema: labwpl; Owner: -
--

CREATE INDEX ix_ttmum_hero_rating_rwid ON labwpl.labwpl_hero_rating USING btree (rating_week_id);


--
