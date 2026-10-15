-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdd_v1
-- Object: ix_ttmum_hero_rating_rwid
-- Type: INDEX

-- Name: ix_ttmum_hero_rating_rwid; Type: INDEX; Schema: labdd_v1; Owner: -
--

CREATE INDEX ix_ttmum_hero_rating_rwid ON labdd_v1.labdd_v1_hero_rating USING btree (rating_week_id);


--
