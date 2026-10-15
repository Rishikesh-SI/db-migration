-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpbl
-- Object: ix_pkl_rating_week_woty
-- Type: INDEX

-- Name: ix_pkl_rating_week_woty; Type: INDEX; Schema: labpbl; Owner: -
--

CREATE INDEX ix_pkl_rating_week_woty ON labpbl.labpbl_rating_week USING btree (week_of_year);


--
