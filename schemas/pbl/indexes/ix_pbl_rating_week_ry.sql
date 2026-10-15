-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pbl
-- Object: ix_pbl_rating_week_ry
-- Type: INDEX

-- Name: ix_pbl_rating_week_ry; Type: INDEX; Schema: pbl; Owner: -
--

CREATE INDEX ix_pbl_rating_week_ry ON pbl.pbl_rating_week USING btree (rating_year);


--
