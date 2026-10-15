-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tsk
-- Object: ix_tsk_hero_rating_rwid
-- Type: INDEX

-- Name: ix_tsk_hero_rating_rwid; Type: INDEX; Schema: tsk; Owner: -
--

CREATE INDEX ix_tsk_hero_rating_rwid ON tsk.tsk_hero_rating USING btree (rating_week_id);


--
