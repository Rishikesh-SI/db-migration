-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dd_30_04_24
-- Object: ix_dd_hero_rating_wn
-- Type: INDEX

-- Name: ix_dd_hero_rating_wn; Type: INDEX; Schema: dd_30_04_24; Owner: -
--

CREATE INDEX ix_dd_hero_rating_wn ON dd_30_04_24.dd_hero_rating USING btree (entity_role_map_id);


--
