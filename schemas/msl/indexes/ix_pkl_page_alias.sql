-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: msl
-- Object: ix_pkl_page_alias
-- Type: INDEX

-- Name: ix_pkl_page_alias; Type: INDEX; Schema: msl; Owner: -
--

CREATE INDEX ix_pkl_page_alias ON msl.msl_page USING btree (alias);


--
