-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: upy
-- Object: ix_upy_hero_rating_wn
-- Type: INDEX

-- Name: ix_upy_hero_rating_wn; Type: INDEX; Schema: upy; Owner: -
--

CREATE INDEX ix_upy_hero_rating_wn ON upy.upy_hero_rating USING btree (entity_role_map_id);


--
