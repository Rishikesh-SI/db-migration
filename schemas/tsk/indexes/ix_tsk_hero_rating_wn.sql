-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tsk
-- Object: ix_tsk_hero_rating_wn
-- Type: INDEX

-- Name: ix_tsk_hero_rating_wn; Type: INDEX; Schema: tsk; Owner: -
--

CREATE INDEX ix_tsk_hero_rating_wn ON tsk.tsk_hero_rating USING btree (entity_role_map_id);


--
