-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: isl
-- Object: ix_isl_hero_rating_wn
-- Type: INDEX

-- Name: ix_isl_hero_rating_wn; Type: INDEX; Schema: isl; Owner: -
--

CREATE INDEX ix_isl_hero_rating_wn ON isl.isl_hero_rating USING btree (entity_role_map_id);


--
