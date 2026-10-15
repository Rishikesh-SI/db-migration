-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkxp
-- Object: ix_kxp_hero_rating_wn
-- Type: INDEX

-- Name: ix_kxp_hero_rating_wn; Type: INDEX; Schema: labkxp; Owner: -
--

CREATE INDEX ix_kxp_hero_rating_wn ON labkxp.labkxp_hero_rating USING btree (entity_role_map_id);


--
