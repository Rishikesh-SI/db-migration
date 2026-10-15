-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrao
-- Object: ix_labrao_web_user_guid
-- Type: INDEX

-- Name: ix_labrao_web_user_guid; Type: INDEX; Schema: labrao; Owner: -
--

CREATE UNIQUE INDEX ix_labrao_web_user_guid ON labrao.labrao_web_user USING btree (user_guid);


--
