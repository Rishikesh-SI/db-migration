-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtcs
-- Object: ix_tsk_hero_rating_wn
-- Type: INDEX

-- Name: ix_tsk_hero_rating_wn; Type: INDEX; Schema: labtcs; Owner: -
--

CREATE INDEX ix_tsk_hero_rating_wn ON labtcs.labtcs_hero_rating USING btree (entity_role_map_id);


--
