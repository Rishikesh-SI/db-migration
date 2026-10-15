-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tmmimg_upd
-- Object: ix_mum_hero_rating_wn
-- Type: INDEX

-- Name: ix_mum_hero_rating_wn; Type: INDEX; Schema: tmmimg_upd; Owner: -
--

CREATE INDEX ix_mum_hero_rating_wn ON tmmimg_upd.tmmimg_upd_hero_rating USING btree (entity_role_map_id);


--
