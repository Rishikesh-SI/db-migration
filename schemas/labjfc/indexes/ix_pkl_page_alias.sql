-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labjfc
-- Object: ix_pkl_page_alias
-- Type: INDEX

-- Name: ix_pkl_page_alias; Type: INDEX; Schema: labjfc; Owner: -
--

CREATE INDEX ix_pkl_page_alias ON labjfc.labjfc_page USING btree (alias);


--
