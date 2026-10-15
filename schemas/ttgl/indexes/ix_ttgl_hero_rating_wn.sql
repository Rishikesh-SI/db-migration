-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: ttgl
-- Object: ix_ttgl_hero_rating_wn
-- Type: INDEX

-- Name: ix_ttgl_hero_rating_wn; Type: INDEX; Schema: ttgl; Owner: -
--

CREATE INDEX ix_ttgl_hero_rating_wn ON ttgl.ttgl_hero_rating USING btree (entity_role_map_id);


--
