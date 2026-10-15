-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtcs
-- Object: ix_tsk_hero_rating_rwid
-- Type: INDEX

-- Name: ix_tsk_hero_rating_rwid; Type: INDEX; Schema: labtcs; Owner: -
--

CREATE INDEX ix_tsk_hero_rating_rwid ON labtcs.labtcs_hero_rating USING btree (rating_week_id);


--
