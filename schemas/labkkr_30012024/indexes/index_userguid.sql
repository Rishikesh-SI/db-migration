-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkkr_30012024
-- Object: index_userguid
-- Type: INDEX

-- Name: index_userguid; Type: INDEX; Schema: labkkr_30012024; Owner: -
--

CREATE INDEX index_userguid ON labkkr_30012024.labkkr_web_user_13032023 USING btree (user_guid);


--
