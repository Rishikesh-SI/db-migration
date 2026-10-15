-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pkl
-- Object: ix_pkl_page_alias
-- Type: INDEX

-- Name: ix_pkl_page_alias; Type: INDEX; Schema: pkl; Owner: -
--

CREATE INDEX ix_pkl_page_alias ON pkl.pkl_page USING btree (alias);


--
