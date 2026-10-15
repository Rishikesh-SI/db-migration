-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labw88
-- Object: ix_ttmum_hero_rating_wn
-- Type: INDEX

-- Name: ix_ttmum_hero_rating_wn; Type: INDEX; Schema: labw88; Owner: -
--

CREATE INDEX ix_ttmum_hero_rating_wn ON labw88.labw88_hero_rating USING btree (entity_role_map_id);


--
