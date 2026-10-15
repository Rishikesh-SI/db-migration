-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labwafdemo
-- Object: ix_ttmum_hero_rating_wn
-- Type: INDEX

-- Name: ix_ttmum_hero_rating_wn; Type: INDEX; Schema: labwafdemo; Owner: -
--

CREATE INDEX ix_ttmum_hero_rating_wn ON labwafdemo.labwafdemo_hero_rating USING btree (entity_role_map_id);


--
