-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tsk
-- Object: ix_tsk_rating_week_wn
-- Type: INDEX

-- Name: ix_tsk_rating_week_wn; Type: INDEX; Schema: tsk; Owner: -
--

CREATE INDEX ix_tsk_rating_week_wn ON tsk.tsk_rating_week USING btree (week_number);


--
