-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpkl_v1
-- Object: ix_pkl_rating_week_ry
-- Type: INDEX

-- Name: ix_pkl_rating_week_ry; Type: INDEX; Schema: labpkl_v1; Owner: -
--

CREATE INDEX ix_pkl_rating_week_ry ON labpkl_v1.labpkl_v1_rating_week USING btree (rating_year);


--
