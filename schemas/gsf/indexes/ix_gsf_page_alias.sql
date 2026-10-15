-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gsf
-- Object: ix_gsf_page_alias
-- Type: INDEX

-- Name: ix_gsf_page_alias; Type: INDEX; Schema: gsf; Owner: -
--

CREATE INDEX ix_gsf_page_alias ON gsf.gsf_page USING btree (alias);


--
