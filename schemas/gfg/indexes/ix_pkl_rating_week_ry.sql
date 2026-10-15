-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gfg
-- Object: ix_pkl_rating_week_ry
-- Type: INDEX

-- Name: ix_pkl_rating_week_ry; Type: INDEX; Schema: gfg; Owner: -
--

CREATE INDEX ix_pkl_rating_week_ry ON gfg.gfg_rating_week USING btree (rating_year);


--
