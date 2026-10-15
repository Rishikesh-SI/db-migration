-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: upy
-- Object: ix_upy_rating_week_woty
-- Type: INDEX

-- Name: ix_upy_rating_week_woty; Type: INDEX; Schema: upy; Owner: -
--

CREATE INDEX ix_upy_rating_week_woty ON upy.upy_rating_week USING btree (week_of_year);


--
