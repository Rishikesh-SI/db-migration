-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkxp1
-- Object: ix_kxp_hero_rating_wn
-- Type: INDEX

-- Name: ix_kxp_hero_rating_wn; Type: INDEX; Schema: labkxp1; Owner: -
--

CREATE INDEX ix_kxp_hero_rating_wn ON labkxp1.labkxp_hero_rating USING btree (entity_role_map_id);


--
