-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: ttgl
-- Object: ix_ttgl_rating_week_wn
-- Type: INDEX

-- Name: ix_ttgl_rating_week_wn; Type: INDEX; Schema: ttgl; Owner: -
--

CREATE INDEX ix_ttgl_rating_week_wn ON ttgl.ttgl_rating_week USING btree (week_number);


--
