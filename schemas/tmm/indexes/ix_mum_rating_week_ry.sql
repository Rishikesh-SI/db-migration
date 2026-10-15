-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tmm
-- Object: ix_mum_rating_week_ry
-- Type: INDEX

-- Name: ix_mum_rating_week_ry; Type: INDEX; Schema: tmm; Owner: -
--

CREATE INDEX ix_mum_rating_week_ry ON tmm.tmm_rating_week USING btree (rating_year);


--
