-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: ttgl
-- Object: ix_ttgl_rating_week_woty
-- Type: INDEX

-- Name: ix_ttgl_rating_week_woty; Type: INDEX; Schema: ttgl; Owner: -
--

CREATE INDEX ix_ttgl_rating_week_woty ON ttgl.ttgl_rating_week USING btree (week_of_year);


--
