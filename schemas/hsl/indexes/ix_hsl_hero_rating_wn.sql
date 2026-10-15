-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: hsl
-- Object: ix_hsl_hero_rating_wn
-- Type: INDEX

-- Name: ix_hsl_hero_rating_wn; Type: INDEX; Schema: hsl; Owner: -
--

CREATE INDEX ix_hsl_hero_rating_wn ON hsl.hsl_hero_rating USING btree (entity_role_map_id);


--
