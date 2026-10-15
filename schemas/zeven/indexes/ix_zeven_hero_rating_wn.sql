-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: ix_zeven_hero_rating_wn
-- Type: INDEX

-- Name: ix_zeven_hero_rating_wn; Type: INDEX; Schema: zeven; Owner: -
--

CREATE INDEX ix_zeven_hero_rating_wn ON zeven.zeven_hero_rating USING btree (entity_role_map_id);


--
