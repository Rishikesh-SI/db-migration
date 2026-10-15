-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labstlz
-- Object: ix_kxp_hero_rating_wn
-- Type: INDEX

-- Name: ix_kxp_hero_rating_wn; Type: INDEX; Schema: labstlz; Owner: -
--

CREATE INDEX ix_kxp_hero_rating_wn ON labstlz.labstlz_hero_rating USING btree (entity_role_map_id);


--
