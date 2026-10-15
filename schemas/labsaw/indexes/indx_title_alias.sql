-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labsaw
-- Object: indx_title_alias
-- Type: INDEX

-- Name: indx_title_alias; Type: INDEX; Schema: labsaw; Owner: -
--

CREATE INDEX indx_title_alias ON labsaw.labsaw_asset_list USING brin (title_alias);


--
