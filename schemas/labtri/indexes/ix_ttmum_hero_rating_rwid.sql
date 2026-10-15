-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtri
-- Object: ix_ttmum_hero_rating_rwid
-- Type: INDEX

-- Name: ix_ttmum_hero_rating_rwid; Type: INDEX; Schema: labtri; Owner: -
--

CREATE INDEX ix_ttmum_hero_rating_rwid ON labtri.labtri_hero_rating USING btree (rating_week_id);


--
