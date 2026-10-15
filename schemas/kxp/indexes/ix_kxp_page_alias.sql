-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: kxp
-- Object: ix_kxp_page_alias
-- Type: INDEX

-- Name: ix_kxp_page_alias; Type: INDEX; Schema: kxp; Owner: -
--

CREATE INDEX ix_kxp_page_alias ON kxp.kxp_page USING btree (alias);


--
